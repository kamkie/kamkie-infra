<#
.SYNOPSIS
A wrapper around Write-Host that supports selective coloring of
substrings via embedded coloring specifications.

.DESCRIPTION
url: https://stackoverflow.com/a/46046113
In addition to accepting a default foreground and background color,
you can embed one or more color specifications in the string to write,
using the following syntax:
#<fgcolor>[:<bgcolor>]#<text>#

<fgcolor> and <bgcolor> must be valid [ConsoleColor] values, such as 'green' or 'white' (case does not matter).
Everything following the color specification up to the next '#', or impliclitly to the end of the string,
is written in that color.

Note that nesting of color specifications is not supported.
As a corollary, any token that immediately follows a color specification is treated
as text to write, even if it happens to be a technically valid color spec too.
This allows you to use, e.g., 'The next word is #green#green#.', without fear
of having the second '#green' be interpreted as a color specification as well.

.PARAMETER ForegroundColor
Specifies the default text color for all text portions
for which no embedded foreground color is specified.

.PARAMETER BackgroundColor
Specifies the default background color for all text portions
for which no embedded background color is specified.

.PARAMETER NoNewline
Output the specified string withpout a trailing newline.

.NOTES
While this function is convenient, it will be slow with many embedded colors, because,
behind the scenes, Write-Host must be called for every colored span.

.EXAMPLE
Write-HostColored "#green#Green foreground.# Default colors. #blue:white#Blue on white."

.EXAMPLE
'#black#Black on white (by default).#Blue# Blue on white.' | Write-HostColored -BackgroundColor White

#>
function Write-HostColored()
{
    [CmdletBinding()]
    param (
        [parameter(Position = 0, ValueFromPipeline = $true)]
        [string[]] $Text
    ,
        [switch] $NoNewline
    ,
        [ConsoleColor] $BackgroundColor = $host.UI.RawUI.BackgroundColor
    ,
        [ConsoleColor] $ForegroundColor = $host.UI.RawUI.ForegroundColor
    )

    begin {
        # If text was given as a parameter value, it'll be an array.
        # Like Write-Host, we flatten the array into a single string
        # using simple string interpolation (which defaults to separating elements with a space,
        # which can be changed by setting $OFS).
        if ($Text -ne $null)
        {
            $Text = "$Text"
        }
    }

    process {
        if ($Text)
        {

            # Start with the foreground and background color specified via
            # -ForegroundColor / -BackgroundColor, or the current defaults.
            $curFgColor = $ForegroundColor
            $curBgColor = $BackgroundColor

            # Split message into tokens by '#'.
            # A token between to '#' instances is either the name of a color or text to write (in the color set by the previous token).
            $tokens = $Text.split("#")

            # Iterate over tokens.
            $prevWasColorSpec = $false
            foreach ($token in $tokens)
            {

                if (-not$prevWasColorSpec -and $token -match '^([a-z]*)(:([a-z]+))?$')
                {
                # a potential color spec.
                    # If a token is a color spec, set the color for the next token to write.
                    # Color spec can be a foreground color only (e.g., 'green'), or a foreground-background color pair (e.g., 'green:white'), or just a background color (e.g., ':white')
                    try
                    {
                        $curFgColor = [ConsoleColor]$matches[1]
                        $prevWasColorSpec = $true
                    }
                    catch
                    {
                    }
                    if ($matches[3])
                    {
                        try
                        {
                            $curBgColor = [ConsoleColor]$matches[3]
                            $prevWasColorSpec = $true
                        }
                        catch
                        {
                        }
                    }
                    if ($prevWasColorSpec)
                    {
                        continue
                    }
                }

                $prevWasColorSpec = $false

                if ($token)
                {
                    # A text token: write with (with no trailing line break).
                    # !! In the ISE - as opposed to a regular PowerShell console window,
                    # !! $host.UI.RawUI.ForegroundColor and $host.UI.RawUI.ForegroundColor inexcplicably
                    # !! report value -1, which causes an error when passed to Write-Host.
                    # !! Thus, we only specify the -ForegroundColor and -BackgroundColor parameters
                    # !! for values other than -1.
                    # !! Similarly, PowerShell Core terminal windows on *Unix* report -1 too.
                    $argsHash = @{ }
                    if ([int]$curFgColor -ne -1)
                    {
                        $argsHash += @{ 'ForegroundColor' = $curFgColor }
                    }
                    if ([int]$curBgColor -ne -1)
                    {
                        $argsHash += @{ 'BackgroundColor' = $curBgColor }
                    }
                    Write-Host -NoNewline @argsHash $token
                }

                # Revert to default colors.
                $curFgColor = $ForegroundColor
                $curBgColor = $BackgroundColor

            }
        }
        # Terminate with a newline, unless suppressed
        if (-not$NoNewLine)
        {
            write-host
        }
    }
}

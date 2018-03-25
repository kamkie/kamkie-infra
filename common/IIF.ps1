function IIf($If, $IfTrue, $IfFalse)
{
    If ($If -IsNot "Boolean")
    {
        $_ = $If
    }
    If ($If)
    {
        If ($IfTrue -is "ScriptBlock")
        {
            &$IfTrue
        }
        Else
        {
            $IfTrue
        }
    }
    Else
    {
        If ($IfFalse -is "ScriptBlock")
        {
            &$IfFalse
        }
        Else
        {
            $IfFalse
        }
    }
}

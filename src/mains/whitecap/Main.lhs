> module Main where

> import System.IO

> import System.Environment
> import System.Exit

> import Robin.Parser (parseRobin)
> import Robin.Intrinsics (robinIntrinsics)
> import Whitecap.Builtins (whitecapBuiltins, union)
> import Robin.TopLevel (execTopExprs)
> import Robin.Reactor (eventLoop, initReactors)

Command-line Entry Point
------------------------

> main = do
>     args <- getArgs
>     case args of
>         [] -> do
>             putStrLn "Usage: whitecap [--no-builtins] {source.robin}"
>             exitWith $ ExitFailure 1
>         ("--no-builtins":rest) -> do
>             (env, reactors) <- processArgs robinIntrinsics [] rest
>             case reactors of
>                 [] ->
>                     exitWith ExitSuccess
>                 _ -> do
>                     reactors' <- initReactors reactors
>                     eventLoop reactors'
>         _ -> do
>             (env, reactors) <- processArgs whitecapBuiltins [] args
>             case reactors of
>                 [] ->
>                     exitWith ExitSuccess
>                 _ -> do
>                     reactors' <- initReactors reactors
>                     eventLoop reactors'

> processArgs env reactors [] = return (env, reactors)
> processArgs env reactors (filename:rest) = do
>     program <- readFile filename
>     case parseRobin program of
>         Right topExprs -> do
>             (env', reactors') <- execTopExprs env reactors topExprs
>             processArgs env' reactors' rest
>         Left problem -> do
>             hPutStr stderr (show problem)
>             exitWith $ ExitFailure 1

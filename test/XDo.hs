{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

-- FIXME: rename to XDoTool
module XDo where

import           Prelude                   hiding (FilePath)

import           Control.Foldl             (list)

import           Control.Arrow

import           Control.Monad.State.Lazy

import           Data.Either
import           Data.Maybe

import           Data.Text                 (Text)
import qualified Data.Text                 as T
import qualified Data.Text.IO              as T

import           Data.Set                  (Set)
import qualified Data.Set                  as Set

import           Data.Map.Lazy             (Map)
import qualified Data.Map.Lazy             as Map

import           Turtle                    hiding (fp, s)

import qualified Filesystem.Path.CurrentOS as FP



--------------------------------------------------------------------------------

tshow :: (Show s) => s -> Text
tshow = show .> T.pack

(|>) :: a -> (a -> b) -> b
(|>) = flip ($)
infixl 0 |>

(.>) :: (a -> b) -> (b -> c) -> a -> c
(.>) = flip (.)
infixl 9 .>

(<#>) :: (Functor f) => f a -> (a -> b) -> f b
(<#>) = flip (<$>)
infixr 4 <#>

--------------------------------------------------------------------------------

{-

type Window = Int
type Key    = Int
type Button = Int

data Scalar
  = Scalar !Int
  | Delta !Int

data Position = MkPosition !Scalar !Scalar

data WindowSize = MkWindowSize !Scalar !Scalar

data ActionM a -- FIXME
instance Functor ActionM
instance Applicative ActionM
instance Monad ActionM

xdo :: Action -> [Text] -> ActionM ()
xdo = _

close :: [Text] -> ActionM ()
close = xdo Close

kill :: [Text] -> ActionM ()
kill = xdo Kill

setHidden :: Bool -> [Text] -> ActionM ()
setHidden b = xdo (if b then Hide else Show)

setZ :: Int -> [Text] -> ActionM ()
setZ z args = let action = if z < 0 then Lower else Raise
              in replicateM_ (abs z) (xdo action args)

setBelow :: Window -> [Text] -> ActionM ()
setBelow w = xdo (Below w)

setAbove :: Window -> [Text] -> ActionM ()
setAbove w = xdo (Above w)

move :: (Scalar, Scalar) -> [Text] -> ActionM ()
move = _

resize :: (Scalar, Scalar) -> [Text] -> ActionM ()
resize = _

activate :: [Text] -> ActionM ()
activate = xdo Activate

getID :: [Text] -> ActionM ()
getID = xdo Activate



data Action
  = Close
  | Kill
  | Hide
  | Show
  | Raise
  | Lower
  | Below
    { _target :: !Window }
  | Above
    { _target :: !Window }
  | Move
    { _position :: !Position }
  | Resize
    { _size :: !WindowSize }
  | Activate
  | Id
  | PID
  | KeyPress
    { _key :: !Key }
  | KeyRelease
    { _key :: !Key }
  | ButtonPress
    { _button :: !Button }
  | ButtonRelease
    { _button :: !Button }
  | PointerMotion
    { _position :: !Position }

data Command
  = MkCommand
    { _action    :: !Action
    , _windows   :: [Window]
    , _extraArgs :: [Text]
    }

actionPos :: Position -> [Text]
actionPos = _

actionSize :: WindowSize -> [Text]
actionSize = _

actionKey :: Key -> [Text]
actionKey = _

actionButton :: Button -> [Text]
actionButton = actionKey

actionArgs :: Action -> [Text]
actionArgs Close                         = ["close"]
actionArgs Kill                          = ["kill"]
actionArgs Hide                          = ["hide"]
actionArgs Show                          = ["show"]
actionArgs Raise                         = ["raise"]
actionArgs Lower                         = ["lower"]
actionArgs (Below { _target })           = ["below", "-t", tshow _target]
actionArgs (Above { _target })           = ["above", "-t", tshow _target]
actionArgs (Move { _position })          = ["move"] <> actionPos _position
actionArgs (Resize { _size })            = ["resize"] <> actionSize _size
actionArgs Activate                      = ["activate"]
actionArgs Id                            = ["id"]
actionArgs PID                           = ["pid"]
actionArgs (KeyPress { _key })           = ["key_press"] <> actionKey _key
actionArgs (KeyRelease { _key })         = ["key_release"] <> actionKey _key
actionArgs (ButtonPress { _button })     = ["button_press"]
                                           <> actionButton _button
actionArgs (ButtonRelease { _button })   = ["button_release"]
                                           <> actionButton _button
actionArgs (PointerMotion { _position }) = ["pointer_motion"]
                                           <> actionPos _position

runCommand' :: (MonadIO io) => Command -> io (ExitCode, Text, Text)
runCommand' (MkCommand {..}) = procStrictWithErr "xdo" args (pure mempty)
  where
    args = mconcat [actionArgs _action, _extraArgs, map tshow _windows]

tshow :: (Show s) => s -> Text
tshow = show >>> T.pack

-}

"
I am the raw skin of `ToPlaceholderLayer`. I add nothing to the raw skin: the look of a placeholder comes from the children its builder adds.

## Examples

```
ToPlaceholderLayer exampleDefault
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the layer.
"
Class {
	#name : #ToPlaceholderLayerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #'event handling' }
ToPlaceholderLayerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent
]

{ #category : #'event handling' }
ToPlaceholderLayerSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent
]

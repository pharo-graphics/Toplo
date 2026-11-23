"
I am the raw skin of `ToDivider`. I make the bar visible only when it matters: I show a resize cursor and a hovered background when the pointer is over it, and a pressed background while it is pressed. The colors are the `#'divider-hovered-background'` and `#'divider-pressed-background'` tokens, the default background otherwise.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- The bar is thin and sits over the content, so a permanent color would draw a line between the elements. A quiet default and a visible hover are enough to find it.

## Usage

1. `ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the divider.
2. The `ToSkinManager` of the divider installs me and sends me its skin events.

## Implementation Notes

- `innerImageIn:` answers a handle icon that nothing in me uses.
"
Class {
	#name : #ToDividerSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'event handling' }
ToDividerSkin >> dragEndedSkinEvent: anEvent [

	super dragEndedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	anEvent elementDo: [ :e | 
			e mouseCursor: (self resizerCursorIn: e).
			e background: (e valueOfTokenNamed: #'divider-hovered-background') ]
]

{ #category : #'event handling' }
ToDividerSkin >> innerImageIn: aDivider [

	^ aDivider isHorizontal
		  ifTrue: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morehoriz' ]
		  ifFalse: [
		  ToMaterialDesignIconProvider innerImageNamed: 'outlined_morevert' ]
]

{ #category : #'event handling' }
ToDividerSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: Cursor normal.
		e background: e defaultBackground ]
]

{ #category : #'event handling' }
ToDividerSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: (e valueOfTokenNamed: #'divider-pressed-background') ]
]

{ #category : #'event handling' }
ToDividerSkin >> releasedSkinEvent: anEvent [

	super releasedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: e defaultBackground ]
]

{ #category : #accessing }
ToDividerSkin >> resizerCursorIn: aDivider [

	^ aDivider isHorizontal
		  ifTrue: [ Cursor resizeTop ]
		  ifFalse: [ Cursor resizeRight ]
]

"
I am the raw skin of `ToTabGroupElement`. I make it transparent and without border, and pad the container of the add button and the menu with the `#'padding-content-H'` or `#'padding-content-V'` token, according to the orientation.

## Examples

```
ToTabGroupElement exampleTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the group.
"
Class {
	#name : #ToTabGroupElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'event handling' }
ToTabGroupElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e background: Color transparent.
			e border: BlBorder empty.
			e isHorizontal
				ifTrue: [
						e menusContainer padding:
							(BlInsets horizontal:
								 (e valueOfTokenNamed: #'padding-content-H')) ]
				ifFalse: [
						e menusContainer padding:
							(BlInsets vertical: (e valueOfTokenNamed: #'padding-content-V')) ] ]
]

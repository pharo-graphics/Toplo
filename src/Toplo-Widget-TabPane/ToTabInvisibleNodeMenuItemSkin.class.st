"
I am the raw skin of `ToTabInvisibleNodeMenuItem`. I draw a bar at the left of the item when its tab is the selected one.

## Examples

```
ToTabPaneElement exampleManyTabs
```

## Usage

`ToRawTheme>>newSkinFor:` creates me by sending `newRawSkin` to the item.

## Implementation Notes

- The bar is added to the node of the item each time I am installed.
"
Class {
	#name : #ToTabInvisibleNodeMenuItemSkin,
	#superclass : #ToMenuItemSkin,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'event handling' }
ToTabInvisibleNodeMenuItemSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e startInterspace: (e valueOfTokenNamed: #'button-interspace').
			e tabNode item isChecked ifTrue: [
					| bar |
					bar := BlElement new.
					bar constraintsDo: [ :c |
							c ignoreByLayout.
							c vertical matchParent.
							c ignored horizontal alignLeft.
							c horizontal exact: 4 ].
					bar background:
						(e valueOfTokenNamed: #'color-list-primary-selection-focused').
					e holder node addChild: bar ] ]
]

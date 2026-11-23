"
I am the item of a tab: the button, with a label and possibly an icon, that selects the tab. I am a checkable (`ToToggleButton`) that a user can also remove (`TToRemovableItem`).

## Examples

```
ToTabItemElement instanceDefault
```

## Design Rationale

- I am the data item of my list and not only its view: the list manages a node (`ToTabNode`) around me. `removable: true` gives the node a remove button.

## Usage

`ToTabGroupElement>>defaultTabItemFactory` creates me when a client adds tab data. I can also be added directly to a `ToTabListElement`. `ToTabButton` is my subclass for tabs with panes.

## Implementation Notes

- `removeButton` and `removeButtonDo:` go through the holder and its node, so they need me to be in a list.
"
Class {
	#name : #ToTabItemElement,
	#superclass : #ToToggleButton,
	#traits : 'TToRemovableItem',
	#classTraits : 'TToRemovableItem classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #instances }
ToTabItemElement class >> instanceDefault [

	<sampleInstance>
	^ self new
		  labelText: 'Tab';
		  yourself
]

{ #category : #converting }
ToTabItemElement >> asToLabelText [ 

	^ self label asToLabelText
]

{ #category : #skin }
ToTabItemElement >> newRawSkin [ 

	^ ToTabItemElementSkin new
]

{ #category : #removing }
ToTabItemElement >> removeButton [ 

	^ self holder node removeButton
]

{ #category : #removing }
ToTabItemElement >> removeButtonDo: aValuable [

	self holder node removeButtonDo: aValuable 
]

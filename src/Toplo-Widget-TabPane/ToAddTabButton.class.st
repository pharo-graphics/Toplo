"
I am the button that adds a tab to a `ToTabGroupElement`. I am an iconic add button with a border when the pointer is over me.

## Examples

```
ToTabPaneElement exampleRemovableTabs
```

## Usage

`ToTabGroupElement>>initializeAddTabButton` creates me, hidden. `showAddTabItemButton: true` shows me. A click fires a `ToAddButtonClickedEvent`, which the group handles.
"
Class {
	#name : #ToAddTabButton,
	#superclass : #ToIconicAddButton,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'instance creation' }
ToAddTabButton >> newRawSkin [ 

	^ ToAddTabButtonSkin new
]

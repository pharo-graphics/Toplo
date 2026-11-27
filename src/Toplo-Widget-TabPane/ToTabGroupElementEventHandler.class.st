"
I am the event handler of a `ToTabGroupElement`. I add a tab when the add button is clicked, and ask for a new configuration when the resizers of the group change.

## Examples

```
ToTabGroupElement exampleTabs
```

## Usage

`ToTabGroupElement>>defaultEventHandler` creates me and the group adds me in `initialize`. I receive `ToAddButtonClickedEvent`, fired by the add button, and consume it.
"
Class {
	#name : #ToTabGroupElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> addButtonClickedEvent: anEvent [

	anEvent currentTarget addNewTabItem.
	anEvent consume
]

{ #category : #'api - accessing' }
ToTabGroupElementEventHandler >> eventsToHandle [

	^ {
		  BlLayoutResizerChangedEvent.
		  ToAddButtonClickedEvent }
]

{ #category : #'element events handling' }
ToTabGroupElementEventHandler >> layoutResizerChangedEvent: anEvent [

	anEvent currentTarget requestConfiguration
]

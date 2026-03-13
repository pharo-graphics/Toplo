Class {
	#name : #ToCheckableListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'currentTarget'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> addIndexesSelectionCommand: aCommand [
	"'addIndexesSelectionCommand: ' trace. aCommand indexes traceCr."

	aCommand operation deselectAllBefore ifTrue: [
			currentTarget dataAccessor do: [ :checkable |
				checkable privateChecked: false ] ].
	aCommand indexes do: [ :idx |
		(currentTarget dataAccessor at: idx) privateChecked: true ]
]

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> addIntervalSelectionCommand: aCommand [
	"'addIntervalSelectionCommand: ' trace. (aCommand from to: aCommand to) traceCr."
	
	aCommand operation deselectAllBefore ifTrue: [
			currentTarget dataAccessor do: [ :checkable |
				checkable privateChecked: false ] ].
	aCommand from to: aCommand to do: [ :idx |
	(currentTarget dataAccessor at: idx) privateChecked: true ]
]

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> addWholeSelectionCommand: aCommand [
	"'addWholeSelectionCommand: ' traceCr."

	currentTarget dataAccessor do: [ :checkable |
		checkable privateChecked: true ]
]

{ #category : #'api - accessing' }
ToCheckableListElementEventHandler >> eventsToHandle [

	^ {
		  ToListSelecterCommandApplicationRequestEvent.
		  ToListSelectionCommandAppliedEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'event handling' }
ToCheckableListElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [


]

{ #category : #'event handling' }
ToCheckableListElementEventHandler >> listSelecterCommandApplicationRequestEvent: andEvent [
]

{ #category : #'event handling' }
ToCheckableListElementEventHandler >> listSelectionCommandAppliedEvent: aCommandAppliedEvent [
	" entry point method that launch the command handlers "

	" temporarily store the current target for futur use in 
	the command handler methods 
	(my #addXXXCommand: and #removexxxCommand: methods)"
	currentTarget := aCommandAppliedEvent currentTarget.
	
	" check that I'm concerned by the the command (it must be applied on my selection model) "
	aCommandAppliedEvent selectionModel == currentTarget selectionModel
		ifFalse: [ ^ self ].

	" launch the command handlers "
	aCommandAppliedEvent command applyWithOperator: self.
	
	"Release the current target "
	currentTarget := nil
]

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> removeIndexesSelectionCommand: aCommand [
	"'removeIndexesSelectionCommand: ' trace. aCommand indexes traceCr."
	
	aCommand indexes do: [ :idx |
		(currentTarget dataAccessor at: idx) privateChecked: false ]
]

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> removeIntervalSelectionCommand: aCommand [
	"'removeIntervalSelectionCommand: ' trace. (aCommand from to: aCommand to) traceCr."
	
	 aCommand from to: aCommand to do: [ :idx |
	(currentTarget dataAccessor at: idx) privateChecked: false ]
]

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> removeWholeSelectionCommand: aCommand [
	"'removeWholeSelectionCommand: ' traceCr."

	currentTarget dataAccessor do: [ :checkable |
		checkable privateChecked: false ]
]

{ #category : #'command handling' }
ToCheckableListElementEventHandler >> selectionModelShiftCommand: aCommand [
]

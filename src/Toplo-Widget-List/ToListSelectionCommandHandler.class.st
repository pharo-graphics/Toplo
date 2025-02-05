"
I'm part of a larger example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToListSelectionCommandHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'selectionModel',
		'currentTarget'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'command handling' }
ToListSelectionCommandHandler >> addIndexesSelectionCommand: aCommand [


]

{ #category : #'command handling' }
ToListSelectionCommandHandler >> addIntervalSelectionCommand: aCommand [


]

{ #category : #'command handling' }
ToListSelectionCommandHandler >> addWholeSelectionCommand: aCommand [

]

{ #category : #'api - accessing' }
ToListSelectionCommandHandler >> eventsToHandle [

	^ { ToListSelectionCommandAppliedEvent }
]

{ #category : #'event handling' }
ToListSelectionCommandHandler >> listSelectionCommandAppliedEvent: aCommandAppliedEvent [
	" entry point method that launch the command handlers "

	" temporarily store the current target for futur use in 
	the command handler methods 
	(my #addXXXCommand: and #removexxxCommand: methods)"
	currentTarget := aCommandAppliedEvent currentTarget.
	
	" check that I'm concerned by the the command (it must be is applied on my selection model) "
	aCommandAppliedEvent selectionModel == selectionModel
		ifFalse: [ ^ self ].

	" launch the command handlers "
	aCommandAppliedEvent command applyWithOperator: self.
	
	"Release the current target "
	currentTarget := nil
]

{ #category : #'command handling' }
ToListSelectionCommandHandler >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'command handling' }
ToListSelectionCommandHandler >> removeIntervalSelectionCommand: aCommand [


]

{ #category : #'command handling' }
ToListSelectionCommandHandler >> removeWholeSelectionCommand: aCommand [

]

{ #category : #accessing }
ToListSelectionCommandHandler >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

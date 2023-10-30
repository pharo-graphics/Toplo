Class {
	#name : 'ToElementState',
	#superclass : 'Object',
	#instVars : [
		'sourceEvent'
	],
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToElementState class >> sourceEvent: anEvent [

	^ self new sourceEvent: anEvent
]

{ #category : 'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchLookEvent: (self newLookEventFromSourceEvent: self sourceEvent)
]

{ #category : 'skin state engine' }
ToElementState >> enqueueIn: anElement [

	anElement skinStateQueue enqueueState: self in: anElement

]

{ #category : 'accessing' }
ToElementState >> incompatibleStateClasses [

	^ {  }
]

{ #category : 'testing' }
ToElementState >> isPersistent [

	^ true
]

{ #category : 'accessing' }
ToElementState >> lookEventClass [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToElementState >> newLookEventFromSourceEvent: anEvent [

	^ self lookEventClass sourceEvent: anEvent
]

{ #category : 'accessing' }
ToElementState >> sourceEvent [

	^ sourceEvent
]

{ #category : 'accessing' }
ToElementState >> sourceEvent: anEvent [

	sourceEvent := anEvent
]

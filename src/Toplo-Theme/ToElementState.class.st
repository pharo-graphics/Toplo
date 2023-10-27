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

{ #category : 'skin state engine' }
ToElementState >> addAsNextStateIn: anElement [

	anElement skinStateProcessor addSkinState: self in: anElement

]

{ #category : 'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchLookEvent: (self newLookEventFromSourceEvent: self sourceEvent)
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

Class {
	#name : 'ToDroppedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToDroppedState >> incompatibleStateClasses [

	^ {  }
]

{ #category : 'testing' }
ToDroppedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToDroppedState >> lookEventClass [

	^ ToDroppedLookEvent
]

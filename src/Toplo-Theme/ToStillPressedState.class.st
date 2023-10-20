Class {
	#name : 'ToStillPressedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToStillPressedState >> incompatibleStateClasses [

	^ { ToPressedState }   
]

{ #category : 'testing' }
ToStillPressedState >> isPersistent [ 

	^ false
]

{ #category : 'accessing' }
ToStillPressedState >> lookEventClass [

	^ ToStillPressedLookEvent
]

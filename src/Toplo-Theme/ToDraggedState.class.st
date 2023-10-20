Class {
	#name : 'ToDraggedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToDraggedState >> incompatibleStateClasses [

	^ { ToReleasedState }
]

{ #category : 'accessing' }
ToDraggedState >> lookEventClass [

	^ ToDraggedLookEvent
]

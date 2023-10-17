Class {
	#name : 'ToDeselectedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToDeselectedState >> incompatibleStateClasses [

	^ { ToSelectedState }
]

{ #category : 'accessing' }
ToDeselectedState >> lookEventClass [

	^ ToDeselectedLookEvent
]

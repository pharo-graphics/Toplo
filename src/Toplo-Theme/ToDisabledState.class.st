Class {
	#name : 'ToDisabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToDisabledState >> incompatibleStateClasses [

	^ { ToEnabledState }
]

{ #category : 'look event sending' }
ToDisabledState >> lookEventClass [

	^ ToDisabledLookEvent
]

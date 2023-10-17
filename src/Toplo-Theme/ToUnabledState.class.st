Class {
	#name : 'ToUnabledState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToUnabledState >> incompatibleStateClasses [

	^ { ToDisabledState }     
]

{ #category : 'accessing' }
ToUnabledState >> lookEventClass [

	^ ToUnabledLookEvent 
]

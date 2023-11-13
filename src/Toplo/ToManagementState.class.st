Class {
	#name : 'ToManagementState',
	#superclass : 'ToImplicitState',
	#category : 'Toplo-Core-States',
	#package : 'Toplo',
	#tag : 'Core-States'
}

{ #category : 'accessing' }
ToManagementState >> lookEventClass [

	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ToManagementState >> newLookEvent [

	^ self lookEventClass sourceEvent: self sourceEvent 
]

Class {
	#name : #ToWrappedListGenericNodeManager,
	#superclass : #ToWrappedListNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToWrappedListGenericNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager.

]

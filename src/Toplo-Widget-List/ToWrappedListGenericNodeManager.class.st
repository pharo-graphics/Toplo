Class {
	#name : #ToWrappedListGenericNodeManager,
	#superclass : #ToWrappedListNodeManager,
	#traits : 'TToGenericNodeManager',
	#classTraits : 'TToGenericNodeManager classTrait',
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #'t - generic node manager' }
ToWrappedListGenericNodeManager >> defaultNodeHolderFactory [

	^ [ ToWrappedListNodeHolder new ]
]

{ #category : #initialization }
ToWrappedListGenericNodeManager >> initialize [ 

	super initialize.
	self initializeAsGenericNodeManager.

]

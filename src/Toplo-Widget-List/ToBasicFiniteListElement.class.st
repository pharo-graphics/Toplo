Class {
	#name : #ToBasicFiniteListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToFiniteListElement + TToConfigurableFiniteListElementDeprecated',
	#classTraits : 'TToFiniteListElement classTrait + TToConfigurableFiniteListElementDeprecated classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #accessing }
ToBasicFiniteListElement >> defaultFakeDataItem [

	^ nil
]

{ #category : #initialization }
ToBasicFiniteListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeContainerFactory: [ ToFiniteListNodeContainer new ];
		  yourself
]

{ #category : #initialization }
ToBasicFiniteListElement >> initialize [

	super initialize.
	self initializeAsFiniteListElement
]

{ #category : #configuration }
ToBasicFiniteListElement >> newToConfiguration [ 

	^ ToBasicFiniteListElementConfiguration new
]

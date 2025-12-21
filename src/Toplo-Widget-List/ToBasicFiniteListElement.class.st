Class {
	#name : #ToBasicFiniteListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToConfigurableFiniteListElementDeprecated',
	#classTraits : 'TToConfigurableFiniteListElementDeprecated classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #configuration }
ToBasicFiniteListElement >> newToConfiguration [ 

	^ ToBasicFiniteListElementConfiguration new
]

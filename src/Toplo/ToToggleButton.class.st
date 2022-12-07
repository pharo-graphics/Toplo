Class {
	#name : #ToToggleButton,
	#superclass : #ToButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #factory }
ToToggleButton class >> horizontal [

	^ ToHorizontalToggleButton new
]

{ #category : #factory }
ToToggleButton class >> vertical [

	^ ToVerticalToggleButton new
]

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToToggleButtonDresser new
]

{ #category : #'checking protocol' }
ToToggleButton >> whenCheckedDo: aBlock [

	(self stateNamed: #checked) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

{ #category : #'checking protocol' }
ToToggleButton >> whenUncheckedDo: aBlock [

	(self stateNamed: #unchecked) whenEnterDo: [:ann | aBlock cull: ann widget ]
]

Class {
	#name : #ToFiniteListItemNodeContainer,
	#superclass : #ToFiniteListNodeContainer,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToFiniteListItemNodeContainer >> aroundNodeConfiguration: aNodeConfigurationBlock [

	| finiteList |
	super aroundNodeConfiguration: aNodeConfigurationBlock.
	finiteList := self holder listElement.
	finiteList isFlowable ifTrue: [ ^ self ].
	self node item isHMatchParent
		ifTrue: [ self hMatchParent ]
		ifFalse: [ self hFitContent ].
	self node item isVMatchParent
		ifTrue: [ self vMatchParent ]
		ifFalse: [ self vFitContent ]
]

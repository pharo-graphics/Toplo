Class {
	#name : #ToItemNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNodeContainer >> aroundNodeConfiguration: aNodeConfigurationBlock [

	| finiteList |
	super aroundNodeConfiguration: aNodeConfigurationBlock.
	finiteList := self holder listElement.
	finiteList toConfiguration isFlowable ifTrue: [ ^ self ].
	self isHExact ifFalse: [
			self node item isHExact
				ifTrue: [ self hFitContent ]
				ifFalse: [
						self node item isHMatchParent
							ifTrue: [ self hMatchParent ]
							ifFalse: [ self hFitContent ] ] ].
	self isVExact ifFalse: [
			self node item isVExact
				ifTrue: [ self vFitContent ]
				ifFalse: [
						self node item isVMatchParent
							ifTrue: [ self vMatchParent ]
							ifFalse: [ self vFitContent ] ] ]
]

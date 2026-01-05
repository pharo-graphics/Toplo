Class {
	#name : #ToItemNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNodeContainer >> aroundNodeConfiguration: aNodeConfigurationBlock [

	| finiteList |
	super aroundNodeConfiguration: aNodeConfigurationBlock.
	self isFake ifTrue: [ ^ self ].
	finiteList := self holder listElement.
	finiteList innerConfiguration isFlowable ifTrue: [ ^ self ].
	self node item ifNil: [ ^ self ].
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

{ #category : #initialization }
ToItemNodeContainer >> initialize [

	super initialize
]

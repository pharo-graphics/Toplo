Class {
	#name : #ToItemNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToItemNodeContainer >> aroundNodeConfiguration: aNodeConfigurationBlock [

	super aroundNodeConfiguration: aNodeConfigurationBlock.
	self node item isHMatchParent ifFalse: [ self hFitContent ].
	self node item isVMatchParent ifFalse: [ self vFitContent ]
]

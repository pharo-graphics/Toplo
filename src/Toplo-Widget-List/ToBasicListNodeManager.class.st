"
I have the responsibility to build the nodeContainers, the nodeHolders and the nodes.
For each data item I create a nodeContainer, its node and the holder that relates the data, the list, and the nodeContainer.  
"
Class {
	#name : #ToBasicListNodeManager,
	#superclass : #Object,
	#traits : 'TToListNodeManager',
	#classTraits : 'TToListNodeManager classTrait',
	#instVars : [
		'checkableNode'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'t - list node manager' }
ToBasicListNodeManager >> buildNodeContainer: aNodeContainer [

	| listElement cbox |
	checkableNode ifFalse: [ ^ self ].
	listElement := aNodeContainer holder listElement.
	cbox := listElement newCheckboxInNodeContainer: aNodeContainer.
	cbox constraintsDo: [ :c | c linear vertical alignCenter ].
	aNodeContainer ensureStartContainer.
	aNodeContainer startContainer addChild: cbox.
	
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode [

	^ checkableNode
]

{ #category : #accessing }
ToBasicListNodeManager >> checkableNode: aBoolean [

	checkableNode := aBoolean 
]

{ #category : #initialization }
ToBasicListNodeManager >> initialize [ 

	super initialize.
	self initializeAsListNodeManager.
	checkableNode := false
]

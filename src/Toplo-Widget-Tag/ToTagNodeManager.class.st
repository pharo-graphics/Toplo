Class {
	#name : #ToTagNodeManager,
	#superclass : #ToGenericBarNodeManager,
	#instVars : [
		'compositeNodeBuilder',
		'tagBuilder'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'t - generic node manager' }
ToTagNodeManager >> buildNode: aNode [ 

	" tagModel can be nil for the fakeNode "
	aNode holder tagModel ifNil: [ ^ self ].
	aNode holder tagModel
		buildNode: aNode
		fromManager: self
]

{ #category : #'node building' }
ToTagNodeManager >> buildNode: aNode forCompositeTagModel: aTagModel [

	compositeNodeBuilder
		value: aNode
		value: aTagModel
		value: aNode holder
]

{ #category : #'node building' }
ToTagNodeManager >> buildNode: aNode forSingleTagModel: aTagModel [

	nodeBuilder cull: aNode cull: aTagModel data cull: aNode holder.
	aNode addEventHandlerOn: ToRemoveShotEvent do: [ :event |
		event consume.
		event currentTarget removeFromBar ]
]

{ #category : #accessing }
ToTagNodeManager >> compositeNodeBuilder: aValuable [

	" aValuable takes the node, then the compositeDataItem then the holder as arguments "
	compositeNodeBuilder := aValuable 
]

{ #category : #initialization }
ToTagNodeManager >> constraintNode: aNode [

	super constraintNode: aNode
]

{ #category : #initialization }
ToTagNodeManager >> defaultCompositeNodeBuilder [

	^ [ :node :compositeTagModel :holder |
	  node addChild: (ToLabel text: compositeTagModel content asString) ]
]

{ #category : #'t - generic node manager' }
ToTagNodeManager >> defaultNodeBuilder [

	^ [ :node :data :holder |
	  | tagElement |
	  tagElement := ToTagElement new.
	  tagBuilder cull: tagElement cull: data cull: holder.
	  tagElement hMatchParent.
	  tagElement endFlexible: true.
	  node addChild: tagElement ]
]

{ #category : #'t - generic node manager' }
ToTagNodeManager >> defaultNodeFactory [

	^ [ :holder | ToTagNode new ]
]

{ #category : #initialization }
ToTagNodeManager >> defaultTagBuilder [

	^ [ :tag :data :holder | tag labelText: data asString ]
]

{ #category : #initialization }
ToTagNodeManager >> initialize [ 

	super initialize.
	compositeNodeBuilder := self defaultCompositeNodeBuilder.
	tagBuilder := self defaultTagBuilder 
]

{ #category : #'t - generic node manager' }
ToTagNodeManager >> newHolder [

	^ ToTagNodeHolder new
]

{ #category : #'t - generic node manager' }
ToTagNodeManager >> newNodeForHolder: aNodeHolder [

	^  ToTagNode new
]

{ #category : #accessing }
ToTagNodeManager >> tagBuilder: aValuable [
	" a valuable takes the tag element, the data and the holder as argument "

	tagBuilder := aValuable
]

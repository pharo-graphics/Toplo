Class {
	#name : #ToTagNode,
	#superclass : #ToBarNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #initialization }
ToTagNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	removable := true
]

{ #category : #skin }
ToTagNode >> installRawStyle [

	super installRawStyle.
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: 'border-radius')).
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'bar-node-padding-H')
			 vertical: (self valueOfTokenNamed: #'bar-node-padding-V')).
	(self holder node isFake not and: [ self holder tagModel isComposite ])
		ifTrue: [
			self tooltipBuilder: [ :win :theElement |
				| pane |
				pane := ToPane vertical.
				self holder tagModel items do: [ :item |
					pane addChild: (ToLabel text: item data asString) ].
				win root addChild: pane ] ]
]

{ #category : #testing }
ToTagNode >> isRemovable [

	^ removable and: [  self nodesCount = 1 ]
]

{ #category : #accessing }
ToTagNode >> nodesCount [ 

	^ self holder tagModel nodesCount
]

{ #category : #accessing }
ToTagNode >> removeButton [ 

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #private }
ToTagNode >> removeFromBar [

	self holder removeNodeFromBar 
]

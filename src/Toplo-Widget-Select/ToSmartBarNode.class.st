Class {
	#name : #ToSmartBarNode,
	#superclass : #ToBarNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - list node' }
ToSmartBarNode >> clickEventHandlerClasses [

	^  { ToListNodeMultiSelectionClickEventHandler } 
]

{ #category : #initialization }
ToSmartBarNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	removable := true
]

{ #category : #skin }
ToSmartBarNode >> installRawStyle [

	super installRawStyle.
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: 'border-radius')).
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'bar-node-padding-H')
			 vertical: (self valueOfTokenNamed: #'bar-node-padding-V')).
	(self holder node isFake not and: [ self holder dataItem isComposite ])
		ifTrue: [
			self tooltipBuilder: [ :win :theElement |
				| pane |
				pane := ToPane vertical.
				self holder dataItem items do: [ :item |
					| t |
					t := self holder dataAccessor at: item index.
					pane addChild: (ToLabel text: t asString) ].
				win root addChild: pane ] ]
]

{ #category : #testing }
ToSmartBarNode >> isRemovable [

	^ removable and: [  self nodesCount = 1 ]
]

{ #category : #accessing }
ToSmartBarNode >> nodesCount [ 

	^ self holder dataItem nodesCount
]

{ #category : #accessing }
ToSmartBarNode >> removeButton [ 

	^ self childWithId: #removeButton ifNone: [  ]
]

{ #category : #private }
ToSmartBarNode >> removeFromBar [

	self holder removeNodeFromBar 
]

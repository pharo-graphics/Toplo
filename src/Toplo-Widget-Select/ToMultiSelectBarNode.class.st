Class {
	#name : #ToMultiSelectBarNode,
	#superclass : #ToBarNode,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'t - list node' }
ToMultiSelectBarNode >> clickEventHandlerClasses [

	^  { ToListNodeMultiSelectionClickEventHandler } 
]

{ #category : #initialization }
ToMultiSelectBarNode >> initialize [

	super initialize.
	self applySkinInstallerOnFirstRequest: true.
	removable := true
]

{ #category : #skin }
ToMultiSelectBarNode >> installRawStyle [

	super installRawStyle.
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: 'border-radius')).
	self holder dataItem isComposite ifTrue: [
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
ToMultiSelectBarNode >> isRemovable [

	^ removable and: [  self nodesCount = 1 ]
]

{ #category : #accessing }
ToMultiSelectBarNode >> nodesCount [ 

	^ self holder dataItem nodesCount
]

{ #category : #private }
ToMultiSelectBarNode >> removeFromBar [

	self holder removeNodeFromBar 
]

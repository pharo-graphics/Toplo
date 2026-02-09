Class {
	#name : #ToNodeHolderForSkinEventTest,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-Tests-Core-ListElement'
}

{ #category : #selection }
ToNodeHolderForSkinEventTest >> notifyNodeSelected: isSelected selectionOption: aSelectionOption [

	self node userData at: #testAction ifPresent: [ :v | v value ].
	super notifyNodeSelected: isSelected selectionOption: aSelectionOption
]

"
I define the simple selection strategy. 
I allow tables using me to manage single selection rows.
"
Class {
	#name : #ToFTSimpleSelectionStrategy,
	#superclass : #ToFTSelectionStrategy,
	#category : #'Toplo-FastTable-Selection'
}

{ #category : #testing }
ToFTSimpleSelectionStrategy >> isMultiple [
	^ false
]

{ #category : #accessing }
ToFTSimpleSelectionStrategy >> selectIndex: rowIndex event: event [
	self toggleIndex: rowIndex
]

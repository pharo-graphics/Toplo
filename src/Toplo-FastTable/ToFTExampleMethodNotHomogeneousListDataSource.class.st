Class {
	#name : #ToFTExampleMethodNotHomogeneousListDataSource,
	#superclass : #ToFTExampleMethodListDataSource,
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #accessing }
ToFTExampleMethodNotHomogeneousListDataSource >> cellColumn: column row: rowIndex [

	^ ToFTCellElement new
		cellInset: 5;
		addMorphBack: (self iconFor: rowIndex) asMorph;
		addMorphBack: (Morph new
			changeTableLayout;
			hResizing: #shrinkWrap;
			listDirection: #topToBottom;
			color: Color transparent;
			addMorphBack: ((self dataAt: rowIndex) protocol asMorph emphasis: 2r10);
			addMorphBack: (self dataAt: rowIndex) name asMorph;
			yourself);
		yourself
]

{ #category : #accessing }
ToFTExampleMethodNotHomogeneousListDataSource >> rowHeight: rowIndex [

	^ 50
]

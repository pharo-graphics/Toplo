Class {
	#name : #ToListSelectionWithSeparateElementOption,
	#superclass : #ToListSelectionWithElementOption,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #testing }
ToListSelectionWithSeparateElementOption >> isSeparate [

	^ true
]

{ #category : #'nodes collecting' }
ToListSelectionWithSeparateElementOption >> newSelectionRepresentationArrayFrom: aListElement withSelectionModel: aSelectionModel [

	^ (aListElement nodeContainersSelect: [ :container |
		   | idx |
		   idx := container holder position.
		   (aSelectionModel containsIndex: idx) and: [
			   aSelectionModel isVisibleIndex: idx ] ]) collect: [ :container |
		  ToSeparateSelection new
			  node: container;
			  createSelectionElementIn: aListElement option: selectionOption;
			  yourself ]
]

Class {
	#name : #ToCheckbox,
	#superclass : #ToLinearButton,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #initialization }
ToCheckbox >> defaultViewModel [ 

	^ ToCheckboxModel new
]

{ #category : #'api - checked change hook' }
ToCheckbox >> ifChecked: checkedBloc unchecked: uncheckedBloc else: indeterminateBlock [

	^ self viewModel ifChecked: checkedBloc unchecked: uncheckedBloc else: indeterminateBlock
]

{ #category : #'api - checked change hook' }
ToCheckbox >> whenCheckedChangedDo: aBlock [

	self viewModel whenCheckedChangedDo: aBlock
]

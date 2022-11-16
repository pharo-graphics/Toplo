Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #initialization }
ToCheckbox >> defaultDresser [

	^ ToCheckboxDresser new
]

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

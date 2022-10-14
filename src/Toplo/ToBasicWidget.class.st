Class {
	#name : #ToBasicWidget,
	#superclass : #ToWidget,
	#instVars : [
		'viewModel'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #initialization }
ToBasicWidget >> defaulViewModel [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToBasicWidget >> viewModel [

	^ viewModel
]

{ #category : #accessing }
ToBasicWidget >> viewModel: aViewModel [

	self viewModelDo: [ :aCurrentModel | 
		aCurrentModel onUninstalledIn: self ].
	viewModel := aViewModel.
	aViewModel onInstalledIn: self
]

Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#instVars : [
		'viewModel'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToWidget >> viewModel [

	^ viewModel
]

{ #category : #accessing }
ToWidget >> viewModel: aViewModel [

	self viewModelDo: [ :aCurrentModel | 
		aCurrentModel onUninstalledIn: self ].
	viewModel := aViewModel.
	aViewModel onInstalledIn: self
]

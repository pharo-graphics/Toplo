Class {
	#name : #ToSelectInnerContainerElement,
	#superclass : #ToElement,
	#instVars : [
		'filtrable',
		'windowManager',
		'selectionModel',
		'dataAccessor',
		'textInputElement'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectInnerContainerElement >> defaultLayout [

	^ BlLinearLayout new
]

{ #category : #accessing }
ToSelectInnerContainerElement >> filterString [ 

	^ textInputElement filterString
]

{ #category : #accessing }
ToSelectInnerContainerElement >> filtrable: aBoolean [

	filtrable := aBoolean.
	textInputElement selectFiltrable: aBoolean
]

{ #category : #accessing }
ToSelectInnerContainerElement >> inputTextField [

	^ textInputElement inputTextField
]

{ #category : #testing }
ToSelectInnerContainerElement >> isFiltrable [

	^ filtrable
]

{ #category : #'api - hooks' }
ToSelectInnerContainerElement >> onInstalledIn: aSelectElement [

	self
		vFitContent;
		hMatchParent;
		constraintsDo: [ :c | c linear vertical alignCenter ].

	filtrable := aSelectElement isFiltrable.
	windowManager := aSelectElement windowManager.
	selectionModel := aSelectElement selectionModel.
	dataAccessor := aSelectElement dataAccessor
]

{ #category : #'accessing - selection' }
ToSelectInnerContainerElement >> onSelectionChangedInSelectElement: aSelectElement [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToSelectInnerContainerElement >> onUninstalledIn: aSelectElement [

	selectionModel := nil.
	dataAccessor := nil.

]

{ #category : #window }
ToSelectInnerContainerElement >> onWindowClosed [

	textInputElement onWindowClosed
]

{ #category : #window }
ToSelectInnerContainerElement >> onWindowOpened [

	textInputElement onWindowOpened
]

{ #category : #accessing }
ToSelectInnerContainerElement >> refresh [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSelectInnerContainerElement >> selectedDataTextField [

	^ textInputElement selectedDataTextField
]

{ #category : #accessing }
ToSelectInnerContainerElement >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelectInnerContainerElement >> textInputElement [

	^ textInputElement
]

{ #category : #initialization }
ToSelectInnerContainerElement >> textInputElementClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSelectInnerContainerElement >> windowManager [ 

	^ windowManager
]

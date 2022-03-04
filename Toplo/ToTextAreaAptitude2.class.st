Class {
	#name : #ToTextAreaAptitude2,
	#superclass : #ToEditorAptitude,
	#category : #'Toplo-Editor-Look'
}

{ #category : #'focus handlers' }
ToTextAreaAptitude2 >> blurEvent: anEvent [
	self widgetContent
		border: (BlBorder paint: self theme editor borderColor width: 1)
]

{ #category : #'focus handlers' }
ToTextAreaAptitude2 >> focusEvent: anEvent [

	self widgetContent
		border: (BlBorder paint: self theme editor focusedBorderColor width: 1)
]

{ #category : #initialization }
ToTextAreaAptitude2 >> initialize [
	super initialize.

	self
		addChangeProperty2: #(widget constraints vertical resizer)
		with: BlLayoutResizer fitContent.
	self
		addChangeProperty2: #(widget constraints horizontal resizer)
		with: BlLayoutResizer matchParent.
	"self
		addChangeProperty: #(widgetContent background)
		with: [ Color white ].
	self
		addChangeProperty: #(widgetContent border)
		with: [ BlBorder paint: Color gray width: 1 ].
	self
		addChangeProperty: #(widget padding)
		with: [ BlInsets
				top: 10
				left: 5
				bottom: 10
				right: 5 ]."

]

{ #category : #initialization }
ToTextAreaAptitude2 >> initializeListeners [
	super initializeListeners.
	
	self when: BlBlurEvent do: [ :anEvent | self blurEvent: anEvent ].
	self when: BlFocusEvent do: [ :anEvent | self focusEvent: anEvent ]
]

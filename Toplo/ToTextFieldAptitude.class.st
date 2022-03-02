Class {
	#name : #ToTextFieldAptitude,
	#superclass : #ToEditorAptitude,
	#category : #'Toplo-Editor-Look'
}

{ #category : #initialization }
ToTextFieldAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widgetContent constraints vertical resizer)
		with: [ BlLayoutResizer fitContent ].
	self
		addChangeProperty: #(widgetContent constraints horizontal resizer)
		with: [ BlLayoutResizer fitContent ].
	self
		addChangeProperty: #(widgetContent border)
		with: [ BlBorder paint: Color gray width: 1 ].

	self
		addChangeProperty: #(widgetContent padding)
		with: [ BlInsets
				top: 5
				left: 5
				bottom: 5
				right: 5 ]
]

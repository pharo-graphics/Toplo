Class {
	#name : #ToSandBox,
	#superclass : #Object,
	#category : #'Toplo-Stuffs'
}

{ #category : #'as yet unclassified' }
ToSandBox class >> example_ToEditorAsTextArea1 [

	| ed space |
	ed := ToEditor new.
	"propagations := BrLayoutResizerPropagations new.
	ed layoutResizerPropagations addPropagations: propagations."
	"ed styles markDirty."

	BrLayoutResizerAptitude inherit onInstalledIn: ed.
	"ed layoutResizerPropagations addPropagations: BrLayoutResizerPropagations new."
	"ed userData at: #brickLook put: nil."
	"ed when: BrEditorStylerChanged do: [ :anEvent | ed styler: anEvent styler ]."
	"ed when: BrEditorTextChanged do: [ :anEvent | ed  text: anEvent text ]."
	"ed when: BrEditorModeChanged do: [ :anEvent | ed mode: anEvent mode ]."
	ed
		when: BlBlurEvent
		do: [ :anEvent | ed border: (BlBorder paint: Color red width: 1) ].
	ed
		when: BlFocusEvent
		do: [ :anEvent | ed border: (BlBorder paint: Color yellow width: 1) ].
	ed constraints vertical resizer: BlLayoutResizer fitContent.
	ed constraints horizontal resizer: BlLayoutResizer fitContent.
	"ed aptitude: ToTextAreaAptitude2."
	ed text: String loremIpsum.
	"ed fitContent."
	"ed fitContent."
	"ed text: String loremIpsum."

	space := BlSpace new.
	space root addChild: ed.
	space title: 'editor'.
	space show.
	^ ed
]

{ #category : #'as yet unclassified' }
ToSandBox class >> example_ToEditorAsTextAreaWithAptitude [

	| ed space |
	ed := ToEditor new aptitude: ToTextAreaAptitude. "BrGlamorousEditorAptitude +"
	"ed vFitContent."
	ed text: String loremIpsum.
	space := BlSpace new.
	space root addChild: ed.
	space title: 'editor'.
	space show.
	^ ed
]

{ #category : #'as yet unclassified' }
ToSandBox class >> example_ToEditorAsTextFieldWithAptitude [

	| ed space |
	ed := ToEditor new
		      aptitude: ToEditorAptitude + ToTextFieldAptitude;
		      text: 'edit me'.

	space := BlSpace new.
	space root addChild: ed.
	space title: 'editor'.
	space show.
	ed
]

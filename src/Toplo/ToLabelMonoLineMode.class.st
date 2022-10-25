Class {
	#name : #ToLabelMonoLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Labels'
}

{ #category : #initialization }
ToLabelMonoLineMode >> newTextElementIn: aLabel [

	^ ToLabelMonoLineInnerElement new
		  editorMeasurement;
		  yourself
]

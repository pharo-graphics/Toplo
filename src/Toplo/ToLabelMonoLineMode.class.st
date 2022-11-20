Class {
	#name : #ToLabelMonoLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToLabelMonoLineMode >> newTextElementIn: aLabel [

	^ ToLabelMonoLineInnerElement new
		  editorMeasurement;
		  yourself
]

Class {
	#name : #ToLabelMonoLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToLabelMonoLineMode >> newTextElement [

	^ BlAttributedTextElement new
		  editorMeasurement;
		  yourself
]

Class {
	#name : #ToExPicsumLoader,
	#superclass : #Object,
	#instVars : [
		'loaded'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #running }
ToExPicsumLoader class >> run [

	<script>
	self new
		loadImages;
		inspect
]

{ #category : #initialization }
ToExPicsumLoader >> loadImages [

	| allImagesData |
	allImagesData := (STONJSON fromString:
		                  'https://picsum.photos/list' asUrl
			                  retrieveContents).
	loaded := Array new: allImagesData size.

	[
		allImagesData withIndexDo: [ :imgData :idx |
				| loader |
				loader := [
					          | timesRetry byteArray |
					          timesRetry := 0.
					          [
						          (byteArray := [
							                        | url |
							                        url := ('https://unsplash.it/100/100/?image='
							                                , idx asString) asUrl.
							                        url retrieveContents ]
							                        on: Error
							                        do: [ ]) isNil and: [ timesRetry < 5 ] ]
						          whileTrue: [ timesRetry := timesRetry + 1 ].
					          byteArray ifNotNil: [
							          | form |
							          form := Form fromBinaryStream: byteArray readStream.
							          loaded at: idx put: form ] ] newProcess.
				loader priority: Processor systemBackgroundPriority.
				loader name: 'ToPicsum.photo Gallery element loader'.
				loader resume ] ] fork
]

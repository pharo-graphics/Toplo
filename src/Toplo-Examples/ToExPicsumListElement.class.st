"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
See `ToSandBox class>>#example_PicsumPhotosGallery`
"
Class {
	#name : #ToExPicsumListElement,
	#superclass : #ToAbstractListElement,
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #initialization }
ToExPicsumListElement >> defaultNodeManagerClass [

	^ ToExPicsumNodeManager
]

Class {
	#name : #ToThemeApplicationPanelModel,
	#superclass : #Object,
	#instVars : [
		'button',
		'panel'
	],
	#category : #'Toplo-Theme-Examples'
}

{ #category : #'as yet unclassified' }
ToThemeApplicationPanelModel >> applyStamp: aStampText [

	self shouldBeImplemented
]

{ #category : #accessing }
ToThemeApplicationPanelModel >> body [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToThemeApplicationPanelModel >> button [

	^ button ifNil: [button := ToButton new
		  labelText: self name;
		  constraintsDo: [ :c | c horizontal matchParent ];
		  yourself] 
]

{ #category : #accessing }
ToThemeApplicationPanelModel >> name [

	^ self shouldBeImplemented
]

{ #category : #accessing }
ToThemeApplicationPanelModel >> panel [

	^ panel ifNil: [
		  panel := ToPane new
			           vertical: true;
			           clipChildren: false;
			           addChild: (ToLabel new
					            text: self name;
					            addStamp: #H1;
					            constraintsDo: [ :c |
						            c horizontal matchParent.
						            c vertical fitContent ];
					            yourself);
			           addChild: self body;
			           constraintsDo: [ :c |
				           c horizontal matchParent.
				           c vertical fitContent ];
			           yourself ]
]

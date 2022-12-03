Trait {
	#name : #TToWidgetWithDresser,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing dresser' }
TToWidgetWithDresser >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - initialization dresser' }
TToWidgetWithDresser >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - accessing dresser' }
TToWidgetWithDresser >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - accessing dresser' }
TToWidgetWithDresser >> dresser: aDresser [

	self dresserDo: [ :d  | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d  | d launchInstallationIn: self ].

]

{ #category : #'t - accessing dresser' }
TToWidgetWithDresser >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - accessing dresser' }
TToWidgetWithDresser >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - initialization dresser' }
TToWidgetWithDresser >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - accessing dresser' }
TToWidgetWithDresser >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]

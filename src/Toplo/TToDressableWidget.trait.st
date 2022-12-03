Trait {
	#name : #TToDressableWidget,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing dresser' }
TToDressableWidget >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - initialization dresser' }
TToDressableWidget >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - accessing dresser' }
TToDressableWidget >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - accessing dresser' }
TToDressableWidget >> dresser: aDresser [

	self dresserDo: [ :d  | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d  | d launchInstallationIn: self ].

]

{ #category : #'t - accessing dresser' }
TToDressableWidget >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - accessing dresser' }
TToDressableWidget >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - initialization dresser' }
TToDressableWidget >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - accessing dresser' }
TToDressableWidget >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]
